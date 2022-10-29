--Case 1 : retrieve the calculated salaty for all employees.  
create or replace function calculate_salary (p_date date) return varchar2
is
cursor c_salary is 
select empno,ename,sal monthly_salary,sal/cast(to_char(last_day(p_date),'dd')as int) daily_sal, (trunc(p_date) - to_date(trunc(p_date,'mm'),'dd-mm-yy')) worked_days , 
sal/cast(to_char(last_day(p_date),'dd')as int) * (trunc(p_date) - to_date(trunc(p_date,'mm'),'dd-mm-yy')) deserved_sal
from scott.emp;

v_empno scott.emp.empno%type;
v_ename scott.emp.ename%type;
v_sal   scott.emp.sal%type;
v_daily number ;
v_worked number ;
v_deserved number;
v_note varchar2 (100):='You can find the output below as (DBMS outpet result) !!!';
begin
open c_salary;
loop
fetch c_salary into v_empno,v_ename,v_sal,v_daily,v_worked,v_deserved;
exit when c_salary%notfound;
dbms_output.put_line('empno: '|| v_empno || ' '|| 'ename: '|| v_ename || ' ' ||
'monthly sal: '|| v_sal|| ' '||'daily sal: '||v_daily||' '||'worked days: '||v_worked|| ' ' ||'deserved sal: '|| v_deserved);
end loop;
return v_note;
end;

select * from scott.emp

select calculate_salary(sysdate) from dual

--************************************************************************************************************************************************************

--Case 1 : retrieve the calculated salaty for specific employee.  
create or replace function calculate_salary_spec (p_empno scott.emp.empno%type,p_date date) return number
is
cursor c_salary is 
select empno,ename,sal monthly_salary,sal/cast(to_char(last_day(p_date),'dd')as int) daily_sal, (trunc(p_date) - to_date(trunc(p_date,'mm'),'dd-mm-yy')) worked_days , 
sal/cast(to_char(last_day(p_date),'dd')as int) * (trunc(p_date) - to_date(trunc(p_date,'mm'),'dd-mm-yy')) deserved_sal
from scott.emp
where empno = p_empno;

v_empno scott.emp.empno%type;
v_ename scott.emp.ename%type;
v_sal   scott.emp.sal%type;
v_daily number ;
v_worked number ;
v_deserved number;
begin
open c_salary;
loop
fetch c_salary into v_empno,v_ename,v_sal,v_daily,v_worked,v_deserved;
exit when c_salary%notfound;
dbms_output.put_line('empno: '|| v_empno || ' '|| 'ename: '|| v_ename || ' ' ||
'monthly sal: '|| v_sal|| ' '||'daily sal: '||v_daily||' '||'worked days: '||v_worked|| ' ' ||'deserved sal: '|| v_deserved);
end loop;
return v_deserved;
end;

select * from scott.emp

select calculate_salary_spec(7839,sysdate) from dual