import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';


@Injectable({
  providedIn: 'root'
})
export class ApiService {
// private apiURL = 'https://localhost:44351/api/';

  constructor(private http: HttpClient) { }

  getStudentList(data: any): Observable<any> {
    return this.http.post(`${environment.apiUrl}Student/GetStudentList`, data);
  }

  saveStudents(data: any): Observable<any> {
    return this.http.post(`${environment.apiUrl}Student/StudentRegister`, data);
  }

  getCommonData(): Observable<any> {
    return this.http.post(`${environment.apiUrl}Common/GetCommonData`, "");
  }

  markAttendance(data: any): Observable<any> {
    return this.http.post(`${environment.apiUrl}Attendance/StudentAttendance`, data);
  }

  getDashboardCounts(): Observable<any> {
    return this.http.get(`${environment.apiUrl}Report/GetDashboardCounts`);
  }

  getStudentReport(data: any): Observable<any[]> {
    return this.http.post<any>(`${environment.apiUrl}Report/GetStudentReport`, data);
  }
}
