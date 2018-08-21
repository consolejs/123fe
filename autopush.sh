#!/bin/sh

echo  "👉 生成博客静态资源👉 : **"


git pull origin master



hexo generate  && cp -r public/. docs

echo  "---------------------"

echo  "🎈 远程库地址🎈 :"

git remote -v

echo  "---------------------"


function autopush()
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
        echo  "🐙 提交日志中...🐙 :"
        echo  "----------------"
		# 判断是否commit成功
		var=$(git commit -m "$commit_msg" 2>&1)
		echo $var
		if [[ "$var" =~ $error_str ]]; then
            echo  "----------------"
			echo "😥提交错误😥 "
            echo  "--------------------->"
		else
            # echo  "--------------------->"
            # echo  "👏 提交成功👏 "
            # echo  "--------------------->"
			break
		fi
	done

	# push
	while [ "1" = "1" ]
	do
        echo  "----------------"
		echo  "😉 正在push到远程库...😉   :"
        echo  "----------------"
		var=$(git push -u origin master 2>&1)
		if [[ $var =~ $error_str ]]; then
			var=$(git push -u origin master 2>&1)
		elif [[ $var =~ "git pull" ]]; then
			echo "😻 pull远程仓库😻 "
			var=$(git pull 2>&1)
			echo $var
		else
			echo $var
            echo  "----------------"
            echo  "👏 push完成👏 "
            echo  "--------------------->"
			break
		fi
	done
}


# push
autopush
