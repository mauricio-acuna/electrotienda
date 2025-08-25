export interface User {
    id: number;
    email: string;
    passwordHash: string;
    role: 'CLIENT' | 'SELLER' | 'ADMIN' | 'SUPER_ADMIN';
    status: 'ACTIVE' | 'INACTIVE';
    createdAt: Date;
    profile: UserProfile;
}

export interface UserProfile {
    firstName: string;
    lastName: string;
    phone: string;
    address: string;
}