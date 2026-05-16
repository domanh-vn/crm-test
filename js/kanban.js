// js/kanban.js
// Xử lý logic riêng cho màn hình Cơ hội (Kanban)

document.addEventListener('DOMContentLoaded', () => {
    renderKanban();
    setupDragAndDrop();
    setupAddLeadForm();
});

function getBadgeColors(segment) {
    if (segment === 'VIP') return 'bg-[#FFF5F5] text-[#C95A5A]';
    if (segment === 'Đại lý') return 'bg-[#FFF8E8] text-[#D4A574]';
    return 'bg-[#E8F4F8] text-[#5A7D9A]'; // Khách lẻ
}

function renderKanban() {
    const leads = window.api.getLeads();
    
    // Clear all columns
    const columns = {
        'mới': document.getElementById('col-moi'),
        'liên hệ': document.getElementById('col-lien_he'),
        'đề xuất': document.getElementById('col-de_xuat'),
        'chốt đơn': document.getElementById('col-chot_don')
    };

    Object.values(columns).forEach(col => { if(col) col.innerHTML = ''; });
    
    // Counters
    const counts = { 'mới': 0, 'liên hệ': 0, 'đề xuất': 0, 'chốt đơn': 0 };

    leads.forEach(lead => {
        const col = columns[lead.stage];
        if (col) {
            counts[lead.stage]++;
            const card = document.createElement('div');
            card.className = "kanban-card glass-card rounded-xl p-4";
            card.draggable = true;
            card.dataset.id = lead.id;
            
            // Format price
            const price = Number(lead.value).toLocaleString() + ' ₫';
            
            // Deadline color
            const isDeadlineUrgent = lead.priority === 'Nóng' || lead.priority === 'Gấp';
            const deadlineClass = isDeadlineUrgent ? 'text-error' : 'text-secondary';
            
            card.innerHTML = `
                <div class="flex justify-between items-start mb-2">
                    <h4 class="font-medium text-[16px] text-[#2C2925]">${lead.name}</h4>
                    <button class="text-secondary hover:text-primary dropdown-btn" onclick="event.stopPropagation();"><span class="material-symbols-outlined text-[18px]">more_vert</span></button>
                </div>
                <div class="text-[20px] font-light text-[#D4A574] mb-3">${price}</div>
                <div class="flex items-center gap-2 mb-4 text-[12px] ${deadlineClass}">
                    <span class="material-symbols-outlined text-[14px]">schedule</span>
                    <span>Còn ${lead.deadline}</span>
                </div>
                <div class="flex flex-wrap gap-2 mb-4">
                    <span class="px-2 py-1 rounded text-[11px] font-medium ${getBadgeColors(lead.segment)}">${lead.segment}</span>
                    <span class="px-2 py-1 rounded text-[11px] font-medium bg-[#FAFAF9] text-secondary border border-[#E8E4DF]">${lead.product}</span>
                </div>
                <div class="flex items-center gap-2 pt-3 border-t border-[#E8E4DF] text-secondary">
                    <div class="w-6 h-6 rounded-full bg-primary/10 flex items-center justify-center text-[10px] text-primary font-bold">
                        ${lead.owner.charAt(0)}
                    </div>
                    <span class="text-[12px]">${lead.owner}</span>
                </div>
            `;
            
            // Add click to open detail
            card.addEventListener('click', (e) => {
                if(!e.target.closest('.dropdown-btn')) {
                    openLeadDetail(lead);
                }
            });
            
            col.appendChild(card);
        }
    });

    // Update counters
    document.getElementById('count-moi').innerText = counts['mới'];
    document.getElementById('count-lien_he').innerText = counts['liên hệ'];
    document.getElementById('count-de_xuat').innerText = counts['đề xuất'];
    document.getElementById('count-chot_don').innerText = counts['chốt đơn'];
    
    setupDragEvents();
}

let draggedCard = null;

function setupDragAndDrop() {
    const columns = document.querySelectorAll('.kanban-column');
    
    columns.forEach(col => {
        col.addEventListener('dragover', e => {
            e.preventDefault();
            col.classList.add('drag-over');
        });
        
        col.addEventListener('dragleave', e => {
            col.classList.remove('drag-over');
        });
        
        col.addEventListener('drop', e => {
            e.preventDefault();
            col.classList.remove('drag-over');
            
            if (draggedCard) {
                const newStage = col.dataset.stage;
                const leadId = draggedCard.dataset.id;
                
                // Update via API
                window.api.updateLeadStage(leadId, newStage);
                
                // Re-render
                renderKanban();
                showToast(`Đã chuyển sang ${newStage}`);
            }
        });
    });
}

function setupDragEvents() {
    const cards = document.querySelectorAll('.kanban-card');
    
    cards.forEach(card => {
        card.addEventListener('dragstart', e => {
            draggedCard = card;
            setTimeout(() => card.classList.add('dragging'), 0);
        });
        
        card.addEventListener('dragend', () => {
            draggedCard = null;
            card.classList.remove('dragging');
        });
    });
}

function setupAddLeadForm() {
    const saveBtn = document.getElementById('saveLeadBtn');
    if (saveBtn) {
        saveBtn.addEventListener('click', () => {
            const name = document.getElementById('leadName').value;
            const value = document.getElementById('leadValue').value;
            const segment = document.getElementById('leadSegment').value;
            const product = document.getElementById('leadProduct').value;
            
            if (!name) {
                showToast('Vui lòng nhập tên khách hàng', 'error');
                return;
            }
            
            window.api.addLead({
                name,
                value: value ? parseInt(value) : 0,
                segment,
                product,
                deadline: '3 ngày',
                priority: 'Mới'
            });
            
            closeModal('addLeadModal');
            document.getElementById('leadName').value = '';
            document.getElementById('leadValue').value = '';
            
            renderKanban();
            showToast('Thêm cơ hội thành công!');
        });
    }
}

let currentActiveLeadId = null;

function openLeadDetail(lead) {
    currentActiveLeadId = lead.id;
    document.getElementById('detailName').innerText = lead.name;
    document.getElementById('detailPhone').innerText = lead.phone || 'Chưa cập nhật';
    document.getElementById('detailStage').innerText = lead.stage;
    document.getElementById('detailValue').innerText = Number(lead.value).toLocaleString() + ' ₫';
    document.getElementById('detailProduct').innerText = lead.product;
    document.getElementById('detailSegment').innerText = lead.segment;
    document.getElementById('detailOwner').innerText = lead.owner;
    openModal('leadDetailModal');
}

window.deleteCurrentLead = function() {
    if(currentActiveLeadId) {
        if(confirm('Bạn có chắc chắn muốn xóa cơ hội này?')) {
            window.api.deleteLead(currentActiveLeadId);
            closeModal('leadDetailModal');
            renderKanban();
            showToast('Đã xóa cơ hội!');
        }
    }
}
