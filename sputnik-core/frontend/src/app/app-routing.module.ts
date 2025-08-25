import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './features/auth/login/login.component';
import { RegisterComponent } from './features/auth/register/register.component';
import { ProductListComponent } from './features/products/product-list/product-list.component';
import { ProductDetailComponent } from './features/products/product-detail/product-detail.component';
import { MarketplaceListComponent } from './features/marketplace/marketplace-list/marketplace-list.component';
import { MarketplaceDetailComponent } from './features/marketplace/marketplace-detail/marketplace-detail.component';
import { OrderHistoryComponent } from './features/orders/order-history/order-history.component';
import { DashboardComponent } from './features/admin/dashboard/dashboard.component';
import { AuthGuard } from './core/auth/auth.guard';

const routes: Routes = [
  { path: '', redirectTo: '/products', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'products', component: ProductListComponent },
  { path: 'products/:id', component: ProductDetailComponent },
  { path: 'marketplace', component: MarketplaceListComponent },
  { path: 'marketplace/:id', component: MarketplaceDetailComponent },
  { path: 'orders', component: OrderHistoryComponent, canActivate: [AuthGuard] },
  { path: 'admin', component: DashboardComponent, canActivate: [AuthGuard] },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }