#!/bin/bash
input=$1;
if [ ! -d "TaskManager" ]
then
	mkdir TaskManager
fi

if [ ! -f "idFile.txt" ] 	
then
 	echo 0 > idFile.txt   
fi
idGenerated(){
	lastId=$(cat ~/idFile.txt)  
	generatedId=$((lastId+1)) 
	echo $generatedId > idFile.txt  
	return $generatedId 
	}
	
errorManag(){
	while true; do 
		read -p "Enter the task number : " taskNumber
		if [ -z $taskNumber ] 
		then 
			echo "The number of the task is required*** " 
		elif [ $taskNumber -lt 0 ] 
		then 
			echo "expecting positive integer"

		elif [[ $taskNumber != ^[0-9]$ ]]
		then
    			echo "Error: Invalid argument. Please enter a valid number"

		else 
			break
		fi
	done
	
	}
displayTask(){
	i=0
	for file in *; do
	    echo "$((i+1)) ------ $file"
	    ((i++))
	done
	}
 
createTask(){ 
	echo "enter informations on you task"
	idGenerated   
	id=$?  
	
	while true; do 
		read -p "task title :" tasktitle
		if [ -z $tasktitle ] 
		then 
			echo "The title of the task is required*** " 
		else 
			break
		fi
	done
	read -p "description :" description
	if [ -z $description ]
	then 
		description="none"
	fi
	
	read -p "location :" location 
	if [ -z $location ] 
	then 
		location="no given location"
	fi 
	while true; do 
		read -p "Due date (YYYY-MM-DD): " dueDate
		if [ -z $dueDate ] 
		then 
			echo "The due date of the task is required*** "
		elif [[ ! "$dueDate" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]  
		then 
			echo "invalid date format. Please enter like this format YYYY-MM-DD"
		else 
			break
		fi
	done
	
	compMark="uncompleted"
	cd "TaskManager"  
	touch ${tasktitle}.txt
	echo "-------------Information on your Task--------" > $tasktitle.txt
	echo "Task Title : $tasktitle" >> "$tasktitle.txt"
	echo "Identifier : $id" >> "$tasktitle.txt"
	echo "Description : $description" >> "$tasktitle.txt"
	echo "Location : $location" >> "$tasktitle.txt"
	echo "Due Date : $dueDate" >> "$tasktitle.txt"
	echo "Completion Mark : $compMark" >> "$tasktitle.txt"
	
	echo "Task created successfully !!!!"
	
	sleep 1  
	gedit $tasktitle.txt 
	
}

updateTask(){
	cd "TaskManager"
	i=0
	displayTask
	errorManag
	i=1
	for file in *; do
		if [ $taskNumber -eq $i ] 
		then 	
			echo "leee fichiiieeeer $file"
			echo "What do you wish to update ? "
			echo "1-------Task Title "
			echo "2-------Description"
			echo "3-------Location"
			echo "4-------Due Date (YYYY-MM-DD)"
			echo "5-------Completion Status"
			read -p "enter number of the field to update : " fieldNumber
			
			case "$fieldNumber" in 
				"1")
					read -p "new title : " newTitle
					oldTitle=$(cat $file | grep 'Task Title' | cut -d ":" -f 2)
					sed -i "s/$oldTitle/$newTitle/g" $file
				;;
				"2")
					read -p "new description : " newDes
					oldDes=$(cat $file | grep 'Description' | cut -d ":" -f 2)
					sed -i "s/'$oldDes'/'$newDes'/g" $file
				;;
				"3")
					read -p "new location : " newLoc
					oldLoc=$(cat $file | grep 'Location' | cut -d ":" -f 2)
					sed -i "s/$oldLoc/$newLoc/g" $file
					echo "the old location $oldLoc"
					echo "the new location $newLoc"
				;;
				"4")
					read -p "new due date : " NewDate
					oldDate=$(cat $file | grep 'Due Date' | cut -d ":" -f 2)
					sed -i "s/$oldDate/$newDate/g" $file
				;;
				"5")
					sed -i 's/uncompleted/completed/g' "$file"
				;;
				  *)
					echo "invalid command !"
					break
				;;
			esac
			
			cat "$file"
			echo "task updated successfully !"
			break
		#else 
			#echo "invalid input. Please enter the correct task number"
		fi
		((i++))
	done
	
	}
	
deleteTask(){
	cd "TaskManager"
	i=0
	
	displayTask
	
	errorManag
	
	i=1
	cpt=1
	for file in *; do
		if [ $taskNumber -eq $i ] 
		then 
			rm "$file"
			echo "task deleted successfully !"
		else 
			((cpt++))
		fi
		((i++))
	done
	if [ $cpt -eq $i ] 
	then 
		echo "invalid input. Please enter the correct task number"
	fi
	}
	
showInfo(){
	cd "TaskManager"
	i=0
	displayTask
	errorManag
	i=1
	cpt=1
	for file in *; do
		if [ $taskNumber -eq $i ] 
		then 
			cat "$file"
		else 
			((cpt++))
		fi
		((i++))
	done
	if [ $cpt -eq $i ] 
	then 
		echo "invalid input. Please enter the correct task number"
	fi	
	}

listTask(){
	cd "TaskManager"
	echo "----------list of tasks on the Task Manager"
	for file in *; do
		echo "$file"
	done	
	}
	
searchTask(){
	cd "TaskManager"
	read -p "search by title : " searchEntry
	for file in *; do
        	if [ -f "$file" ]; then
            		grep -H "$searchEntry" "$file"
	fi
	done
	}
	
taskManual(){
	cat "taskManual.txt"
	}

completeIncompleteTasks(){
	cd "TaskManager"
	i=0
	echo "Complete Tasks"
	for file in *; do
		status=$(cat $file | grep 'Completion Mark' | cut -d ":" -f 2)
		if [ $status = "completed" ] 
		then 
			echo "-----------$file"
		fi
	done
		
	echo "Incomplete Tasks"
	for file in *; do
		status=$(cat $file | grep 'Completion Mark' | cut -d ":" -f 2)
		if [ $status = "uncompleted" ] 
		then 
			echo "-----------$file"
		fi
	done
	}

case "$input" in 
	"create") 
		createTask
	;;
	"update")
		updateTask
	;;
	"delete") 
		deleteTask
	;;
	"showinfo") 
		showInfo
	;;
	"listtask") 
		listTask
	;;
	"search") 
		searchTask
	;;
	"taskmanual") 
		taskManual
	;;
	"")
		completeIncompleteTasks
	;;
	*)
		echo "invalid command !"
		echo "try <task manual> to read manual"
	;;
esac