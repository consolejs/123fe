#!/bin/sh

echo  "👉 生成博客静态资源👉 : **"

# hexo generate  && cp -r public/. docs

# echo  "---------------------"
#
# echo  "🎈 远程库地址🎈 :"
#
# git remote -v
#
# echo  "---------------------"




function gitpush()
{

	error_str="fatal"
	origin_add=""

	# 仓库add
	var=$(git add . 2>&1)
	echo $var

	# commit
	while [ "1" = "1"  ]
	do
		echo  "🌻 输入commit内容🌻 :"
		read commit_msg
        echo  "--------------------->"
        echo  "🐙 正在提交...🐙 :"
        echo  "--------------------->"
		# 判断是否commit成功
		var=$(git commit -m "$commit_msg" 2>&1)
		echo $var
		if [[ "$var" =~ $error_str ]]; then
            echo  "--------------------->"
			echo "😥提交错误😥 "
            echo  "--------------------->"
		fi
	done


	# push
	while [ "1" != "1" ]
	do
		echo "***开始push本地仓库***"
		var=$(git push -u origin master 2>&1)
		if [[ $var =~ $error_str ]]; then
			echo -n "推送失败，未添加远程仓库，是否添加远程仓库(y/n): "
			read add_origin_repo
			if [[ $add_origin_repo = "y" ]]; then
				echo -n "输入远程仓库地址:"
				read origin_add
				var=$(git remote add origin $origin_add 2>&1)
				echo $var
			else
				echo "***退出***"
				break
			fi
			var=$(git push -u origin master 2>&1)
		elif [[ $var =~ "git pull" ]]; then
			echo "***pull远程仓库***"
			var=$(git pull 2>&1)
			echo $var
		else
			echo $var
            echo  "--------------------->"
            echo  "👏 push完成👏 "
            echo  "--------------------->"
			break
		fi
	done
}


gitpush

# echo -n "push当前项目到Git:(y/n)"
# read is_current
# push_folder=""
# echo -n "输入(y/n):" $is_current
# echo
# if [[ $is_current = "y" ]]; then
# 	push_folder=$(pwd)
# elif [[ $is_current = "n" ]]; then
# 	echo -n "请输入项目路径："
# 	read push_folder
# else
# 	push_folder=$(pwd)
# fi


# echo "项目地址:" $push_folder
# dir=$(ls -al $push_folder | awk '/^d/ {print $NF}')
# is_git=0
# for file in ${dir}/.; do
# 	temp_file=`basename $file`
# 	# echo "$temp_file"
# 	if [[ $temp_file =~ ".git" ]]; then
# 		is_git=1
# 		break
# 	fi
# done
#
#
# if [[ $is_git = 1 ]]; then
# 	# 仓库已经初始化，直接push
# 	echo  "***已初始化仓库***"
# 	gitpush
# else
# 	# 当前仓库没有初始化，需要新初始化，然后push
# 	echo "***仓库未初始化，开始初始化仓库***"
# 	var=$(git init 2>&1)
# 	echo $var
#
# 	# 调用提交函数
# 	gitpush
# fi
