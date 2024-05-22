


**Task Manager**

This program helps you manage your tasks and keep track of things you need to do. It stores information in separate files for each task, making it easy to add, update, delete, and view them.

**How it Works:**

-   **Data Storage:** Each task is stored in a separate text file within a directory named "TaskManager". This directory will be created automatically if it doesn't exist. Each file contains details about the task, like title, description, location, due date, and completion status.
-   **Organization:** The script uses functions to perform specific actions, switch statement to test on the different user needs. These functions handle tasks like creating new tasks, updating existing ones, deleting tasks, displaying information, listing all tasks, searching by title, and showing completed or incomplete tasks.

**Using the Task Manager:**

1.  **Run the Script**
2.  **Input Commands:** The script need commands that should be passed as arguments

-   **create:** Add a new task by entering details like title (required), description, location, and due date(required).
-   **update:** Modify an existing task by choosing its number (displayed when you list tasks) and choosing the field to update (title, description, location, due date, or completion status), the modified fields will be replaced by the new value and the unmodified ones remain the same.
-   **delete:** Remove a task by entering its number.
-   **showinfo:** View complete details of a specific task by entering its number.
-   **listtask:** Get a list of all tasks in the TaskManager directory.
-   **search:** Find tasks by searching for keywords in their titles.
-   **taskmanual** : Read the task manager's manual for detailed instructions (taskManual.txt).
-   **Nothing Entered:** By default, the script will show a list of completed and incomplete tasks.


