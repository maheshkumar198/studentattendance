import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from 'src/app/services/api.service';
import { LoaderService } from 'src/app/services/loader.service';

@Component({
  selector: 'app-student-report',
  templateUrl: './student-report.component.html',
  styleUrls: ['./student-report.component.css']
})
export class StudentReportComponent implements OnInit {
  reportForm: FormGroup;
  presentCount = 0;
  absentCount = 0;

  studentList: any = [];
  filteredList: any[] = [];
  viewType: 'Present' | 'Absent' | null = null;

  pageSize = 5;
  pageIndex = 1;
  totalRecords = 0;
  pages: number[] = [];
  

  constructor(private fb: FormBuilder, private apiService: ApiService, private loader: LoaderService) {
    const today = new Date();
    this.reportForm = this.fb.group({
      fromDate: [this.formatDate(today), Validators.required],
      toDate: [this.formatDate(today), Validators.required],
      studentName: [''],
      rollNo: ['']
    });
  }

  formatDate = (date: Date): string => {
      const year = date.getFullYear();
      const month = ('0' + (date.getMonth() + 1)).slice(-2);
      const day = ('0' + date.getDate()).slice(-2);
      return `${year}-${month}-${day}`;
    };

  ngOnInit(): void {
    this.loadDashboardCounts();
  }

  loadDashboardCounts() {
    this.loader.show();
    this.apiService.getDashboardCounts().subscribe((res : any) => {
      if (res.status == 200) {
        this.presentCount = res?.result?.presentCount;
        this.absentCount = res?.result?.absentCount;
      }
      this.loader.hide();
    });
  }

  filterList(type: any = null) {
    if (type == 'Present' && this.presentCount == 0)
      return;
    if (type == 'Absent' && this.absentCount == 0)
      return;

    if (this.reportForm.invalid) {
      this.reportForm.markAllAsTouched();
      return;
    }
    
    this.viewType = type ?? "All";
    const filter = { ...this.reportForm.value, status: type ?? "" };
    if (type == 'Present' || type == 'Absent') {
      const today = new Date();
      const date = this.formatDate(today);
      filter.fromDate = date;
      filter.toDate = date; 
      filter.studentName = "";
      filter.rollNo = "";
    }
    this.apiService.getStudentReport(filter).subscribe((res: any) => {
      if (res.status == 200) {
        this.studentList = res?.result;
        this.pageIndex = 1;
        this.applyPagination();
      }
    });
  }

 applyPagination() {
    this.totalRecords = this.studentList?.length;
    const start = (this.pageIndex - 1) * this.pageSize;
    this.filteredList = this.studentList.slice(start, start + this.pageSize);
    this.pages = Array.from({ length: Math.ceil(this.totalRecords / this.pageSize) }, (_, i) => i + 1);
  }

  onPageChange(page: number) {
    this.pageIndex = page;
    this.applyPagination();
  }
}
