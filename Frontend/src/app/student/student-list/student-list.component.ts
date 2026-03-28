import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { LoaderService } from 'src/app/services/loader.service';

@Component({
  selector: 'app-student-list',
  templateUrl: './student-list.component.html',
  styleUrls: ['./student-list.component.css']
})
export class StudentListComponent implements OnInit {
  data: any;
  commonData: any;
  isEdit : boolean = false;
  pages: number[] = [];
  totalRecords = 0;
  searchKeyword = '';
  pageIndex = 1;
  pageSize = 5;
  sortColumn = 'CreatedDate';
  sortDirection = 'desc';


  studentAddUpdateForm: FormGroup;
  attendanceForm: FormGroup;
  showStudentModal = false;
  showAttendanceModal = false;
  selectedStudent: any = null;

  constructor(
    private apiervice: ApiService, 
    private router: Router,
    private loader: LoaderService,
    private fb: FormBuilder){
      this.studentAddUpdateForm = this.fb.group({
      students: this.fb.array([this.createStudent()])
    });

    this.attendanceForm = this.fb.group({
      attendanceDate: ['', Validators.required],
      status: ['Present', Validators.required]
    });
    }

    ngOnInit(): void {
    this.getCommonData();
    this.loaddata();
  }

getCommonData(): void {
    this.apiervice.getCommonData().subscribe(res => {
      if (res.status == 200) {
        this.commonData = res?.result;
      }
    });
  }
 

  get students() {
    return this.studentAddUpdateForm.get('students') as FormArray;
  }

    createStudent(): FormGroup {
    return this.fb.group({
      id: [0],
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      rollNo: ['', Validators.required],
      class: ['', Validators.required]
    });
  }

  

  loaddata(): void {
    this.loader.show();
    const request = {
      pageIndex: this.pageIndex,
      pageSize: this.pageSize,
      statusId: 1,
      searchKeyword: this.searchKeyword.trim(),
      sortColumn: this.sortColumn,
      sortDirection: this.sortDirection.toUpperCase()
    };

    this.apiervice.getStudentList(request).subscribe(res => {
      if (res.status == 200) {
        this.data = res?.result;
        this.totalRecords = res?.totalCount;

        const totalPages = Math.ceil(this.totalRecords / this.pageSize);
        this.pages = Array.from({ length: totalPages }, (_, i) => i + 1);
      }
      this.loader.hide();
    });
  }

  onSearch(): void {
    this.pageIndex = 1;
    this.loaddata();
  }

  onPageChange(page: number): void {
    this.pageIndex = page;
    this.loaddata();
  }

  onSort(column: string): void {
    if (this.sortColumn === column) {
      this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
    } else {
      this.sortColumn = column;
      this.sortDirection = 'asc';
    }
    this.loaddata();
  }

  openStudentModal(editItem = null) {
    this.showStudentModal = true;
    this.isEdit = false;
    this.students.clear();
    if (editItem) {
      this.isEdit = true;
      this.students.push(this.fb.group({ ...editItem as any }));
    } else {
      this.students.push(this.createStudent());
    }
  }

  addMore() {
    this.students.push(this.createStudent());
  }

  removeStudent(i: number) {
    if (this.students.length > 1) {
      this.students.removeAt(i);
    }
  }

  saveStudents() {
    if (this.studentAddUpdateForm.invalid) return;
    this.studentAddUpdateForm.value.students.forEach((element: any) => {
      const match = this.commonData?.find((x: { id: number, value: string }) => x.value == element.class);
      element.ClassId = match.id;
    });
    this.apiervice.saveStudents(this.studentAddUpdateForm.value.students).subscribe(() => {
      this.showStudentModal = false;
      this.loaddata();
    });
  }

  openAttendanceModal(student: any) {
    this.selectedStudent = student;
    this.attendanceForm.reset({ status: 'Present', attendanceDate: '' });
    this.showAttendanceModal = true;
  }

  markAttendance() {
    if (this.attendanceForm.invalid) return;
    const data = {
      studentId : this.selectedStudent.id,
      attendanceDate : this.attendanceForm?.value?.attendanceDate, 
      status : this.attendanceForm?.value?.status == 'Present' ? 1 : 0,
      remarks : this.attendanceForm?.value?.status
    };
    this.apiervice.markAttendance(data).subscribe(() => {
      this.showAttendanceModal = false;
      alert('Attendance marked successfully');
    });
  }

  getCommonClassNames(): string {
    return this.commonData?.map((c: { value: any; }) => c.value).join(', ') || '';
  }

  validateClass(index: number): void {
    const control = this.students.at(index).get('class');
    const allowedClasses = this.commonData.map((c: { value: any; }) => c.value);
    const value = control?.value;

    if (!allowedClasses.includes(value)) {
      control?.setErrors({ invalidClass: true });
    } else {
      control?.setErrors(null);
    }
  }

  get recordSummary(): string {
    const start = (this.pageIndex - 1) * this.pageSize + 1;
    const end = Math.min(this.pageIndex * this.pageSize, this.totalRecords);
    return `Showing ${start} to ${end} of ${this.totalRecords} records`;
  }
}
