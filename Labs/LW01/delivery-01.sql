select a.dept_no, b.dept_name, sum(s.salary) as salary
from dept_emp as a, departments as b, salaries as s
where a.dept_no = b.dept_no
and a.emp_no = s.emp_no
and a.from_date <= current_date
and a.to_date >= current_date
and s.from_date <= current_date
and s.to_date >= current_date
group by a.dept_no, b.dept_name
order by salary desc;
