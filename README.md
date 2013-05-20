Todo Task Manager
====

Simple tool for managing tasks via command line.

## Example Usage ##

List active tasks.

    todo tasks 
    => Task: Example Task - Priority: 10
       **Brief Description Here**

Create new task.

    todo create_task "Clean clothes" "Need clothes cleaned by friday..." 3
    => Task: Clean clothes - Priority: 3 
       ** Need clothes cleaned by friday..."
       
       Task: Example Task - Priority: 10
       **Brief Description Here**

Delete task.

      todo delete_task "Clean clothes"
      =>  Task: Example Task - Priority: 10
          **Brief Description Here**

Set task priority.

      todo set_priority "Example Task" 4
      =>  Task: Example Task - Priority: 4
          **Brief Description Here**

