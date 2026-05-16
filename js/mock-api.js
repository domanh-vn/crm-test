// js/mock-api.js
// Giả lập cơ sở dữ liệu với LocalStorage để tạo cảm giác sống động cho prototype

const DEFAULT_DATA = {
    leads: [
        { id: 'L1', name: 'Nguyễn Thành Nam', phone: '0901234567', value: 50000000, stage: 'mới', segment: 'VIP', product: 'Yến chưng', deadline: '2 ngày', priority: 'Nóng', owner: 'A. Minh' },
        { id: 'L2', name: 'Lê Thị Hồng', phone: '0912345678', value: 25000000, stage: 'liên hệ', segment: 'Đại lý', product: 'Yến thô', deadline: '3 ngày', priority: 'Mới', owner: 'C. Lan' },
        { id: 'L3', name: 'Trần Văn Kiên', phone: '0923456789', value: 100000000, stage: 'đề xuất', segment: 'VIP', product: 'Yến thô', deadline: '5 ngày', priority: 'Bình thường', owner: 'A. Hoàng' },
        { id: 'L4', name: 'Phạm Anh Quân', phone: '0934567890', value: 15000000, stage: 'chốt đơn', segment: 'Khách lẻ', product: 'Yến chưng', deadline: 'Đã thanh toán', priority: 'Gấp', owner: 'C. Vy' }
    ],
    tasks: [
        { id: 'T1', title: 'Gọi xác nhận đơn hàng #8291', status: 'pending', priority: 'high', due: 'Trễ 3 giờ' },
        { id: 'T2', title: 'Gửi báo giá cho Đại lý X', status: 'done', priority: 'medium', due: 'Hoàn thành' },
        { id: 'T3', title: 'Trả lời email hỗ trợ VIP', status: 'pending', priority: 'high', due: 'Trễ 2 ngày' }
    ],
    invoices: [
        { id: 'INV-0001', customer: 'Nguyễn Thành Nam', amount: 50000000, status: 'Đã thanh toán', date: '15/05/2026' },
        { id: 'INV-0002', customer: 'Lê Thị Hồng', amount: 25000000, status: 'Chưa thanh toán', date: '-' },
        { id: 'INV-0003', customer: 'Phạm Anh Quân', amount: 15000000, status: 'Đã thanh toán', date: '14/05/2026' }
    ],
    users: [
        { id: 'U1', name: 'Nguyễn Phước Vĩnh Hưng', email: 'vinhhung@yensao.com', role: 'Admin', group: '-', status: 'Hoạt động' },
        { id: 'U2', name: 'A. Minh', email: 'minh@yensao.com', role: 'Sales', group: 'Nhóm A', status: 'Hoạt động' },
        { id: 'U3', name: 'C. Lan', email: 'lan@yensao.com', role: 'Manager', group: 'Nhóm A', status: 'Hoạt động' }
    ]
};

class MockAPI {
    constructor() {
        this.init();
    }

    init() {
        if (!localStorage.getItem('lux_crm_data')) {
            localStorage.setItem('lux_crm_data', JSON.stringify(DEFAULT_DATA));
        }
    }

    getData() {
        return JSON.parse(localStorage.getItem('lux_crm_data'));
    }

    saveData(data) {
        localStorage.setItem('lux_crm_data', JSON.stringify(data));
    }

    // Leads (Opportunities)
    getLeads() {
        return this.getData().leads;
    }

    updateLeadStage(leadId, newStage) {
        const data = this.getData();
        const lead = data.leads.find(l => l.id === leadId);
        if (lead) {
            lead.stage = newStage;
            this.saveData(data);
        }
    }

    addLead(lead) {
        const data = this.getData();
        const newLead = {
            id: 'L' + Date.now(),
            stage: 'mới',
            owner: 'Bạn',
            ...lead
        };
        data.leads.push(newLead);
        this.saveData(data);
        return newLead;
    }

    deleteLead(leadId) {
        const data = this.getData();
        data.leads = data.leads.filter(l => l.id !== leadId);
        this.saveData(data);
    }

    // Tasks
    getTasks() {
        return this.getData().tasks;
    }

    toggleTask(taskId) {
        const data = this.getData();
        const task = data.tasks.find(t => t.id === taskId);
        if (task) {
            task.status = task.status === 'pending' ? 'done' : 'pending';
            this.saveData(data);
        }
    }

    deleteTask(taskId) {
        const data = this.getData();
        data.tasks = data.tasks.filter(t => t.id !== taskId);
        this.saveData(data);
    }

    // Invoices
    getInvoices() {
        return this.getData().invoices || [];
    }

    addInvoice(invoice) {
        const data = this.getData();
        if (!data.invoices) data.invoices = [];
        const newInvoice = {
            id: 'INV-00' + (data.invoices.length + 1).toString().padStart(2, '0'),
            ...invoice
        };
        data.invoices.push(newInvoice);
        this.saveData(data);
        return newInvoice;
    }

    // Users
    getUsers() {
        return this.getData().users || [];
    }

    addUser(user) {
        const data = this.getData();
        if (!data.users) data.users = [];
        const newUser = {
            id: 'U' + (data.users.length + 1),
            status: 'Hoạt động',
            ...user
        };
        data.users.push(newUser);
        this.saveData(data);
        return newUser;
    }

    deleteUser(userId) {
        const data = this.getData();
        data.users = data.users.filter(u => u.id !== userId);
        this.saveData(data);
    }
}

// Export a singleton instance
window.api = new MockAPI();
