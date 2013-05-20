Todo Task Manager
====

Simple tool for managing tasks via command line.

## Example Usage ##

List active tasks.

    todo tasks 
    => Task: Example Task - Priority: 10
       ** Brief Description Here **

Create new task.

    todo create_task "Fix Dns Issue" "Need this fixed by Friday..." 3
    => Task: Fix Dns Issue - Priority: 3 
       ** Need this fixed by Friday... **
       
       Task: Example Task - Priority: 10
       ** Brief Description Here **

Delete task.

      todo delete_task "Fix Dns Issue"
      =>  Task: Example Task - Priority: 10
          ** Brief Description Here **

Set task priority.

      todo set_priority "Example Task" 4
      =>  Task: Example Task - Priority: 4
          ** Brief Description Here **

