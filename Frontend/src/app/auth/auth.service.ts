import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, tap } from 'rxjs';
import { environment } from 'src/environments/environment';


@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private tokenKey = 'bearer-token';
  private userData = 'user-data';
  // private apiURL = 'https://localhost:44351/api/';

  constructor(private http: HttpClient, private router: Router) {}

  login(body : any): Observable<boolean> {
    console.log(body);
    return this.http.post<any>(`${environment.apiUrl}Auth/Login`, body).pipe(
      tap(response => {
        if (response.status == 200){
          if (response?.result?.userPermissions.some((x: { permissionName: string; }) => x.permissionName == "StudentList")) {
            localStorage.setItem(this.userData, JSON.stringify(response?.result));
            localStorage.setItem(this.tokenKey, response?.result?.token);
            alert(response?.message);
          }
          else {
            alert("Permission Denied.");
          }
        }
        else{
          alert(response?.message);
        }
      }),
      tap(() => true)
    );
  }

  logout() {
    localStorage.clear();
    sessionStorage.clear();
    this.router.navigate(['/login']);
  }

  isLoggedIn(): boolean {
    return !!localStorage.getItem(this.tokenKey);
  }

  getToken(): string {
    return localStorage.getItem(this.tokenKey) || '';
  }

}
