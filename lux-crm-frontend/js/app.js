// js/app.js
// Logic dùng chung cho giao diện: Sidebar, Toast, Modals

document.addEventListener('DOMContentLoaded', () => {
    initSidebar();
    setupModals();
});

function initSidebar() {
    const currentPath = window.location.pathname.split('/').pop() || 'index.html';
    const links = document.querySelectorAll('aside nav a');
    
    links.forEach(link => {
        const href = link.getAttribute('href');
        if (href === currentPath) {
            // Active state based on design brief
            link.className = "flex items-center gap-4 py-3 px-4 rounded-lg text-primary font-bold border-l-4 border-primary bg-[#FFF8E8] transition-all duration-300";
            // Set icon color if needed
        } else {
            // Inactive state
            link.className = "flex items-center gap-4 py-3 px-4 rounded-lg text-secondary opacity-70 hover:text-primary hover:bg-primary/5 transition-all duration-300";
        }
    });
}

function showToast(message, type = 'success') {
    let container = document.getElementById('toast-container');
    if (!container) {
        container = document.createElement('div');
        container.id = 'toast-container';
        document.body.appendChild(container);
    }

    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    
    const icon = type === 'success' ? 'check_circle' : 'error';
    
    toast.innerHTML = `
        <span class="material-symbols-outlined toast-icon">${icon}</span>
        <div>
            <p class="font-bold text-[14px] text-on-surface">${type === 'success' ? 'Thành công' : 'Lỗi'}</p>
            <p class="text-[12px] text-secondary">${message}</p>
        </div>
    `;

    container.appendChild(toast);
    
    // Animate in
    requestAnimationFrame(() => {
        toast.classList.add('show');
    });

    // Remove after 3s
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

function setupModals() {
    const closeBtns = document.querySelectorAll('.close-modal');
    closeBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            const modalId = e.target.closest('.modal-overlay').id;
            closeModal(modalId);
        });
    });
    
    // Close on overlay click
    const overlays = document.querySelectorAll('.modal-overlay');
    overlays.forEach(overlay => {
        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) {
                closeModal(overlay.id);
            }
        });
    });
}

window.openModal = function(id) {
    const modal = document.getElementById(id);
    if (modal) modal.classList.add('active');
}

window.closeModal = function(id) {
    const modal = document.getElementById(id);
    if (modal) modal.classList.remove('active');
}
