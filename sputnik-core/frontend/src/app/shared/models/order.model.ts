export interface Order {
    id: number;
    userId: number;
    total: number;
    status: string;
    paymentStatus: string;
    createdAt: Date;
    orderItems: OrderItem[];
}

export interface OrderItem {
    id: number;
    orderId: number;
    productId: number;
    quantity: number;
    price: number;
}