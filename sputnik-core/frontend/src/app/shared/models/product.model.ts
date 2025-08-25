export interface Product {
    id: number;
    name: string;
    description: string;
    categoryId: number;
    brand: string;
    model: string;
    price: number;
    images: string[];
    stock: number;
    createdAt: Date;
    updatedAt: Date;
}