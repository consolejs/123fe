#!/bin/sh

echo  "--------------------->"

echo  "👉  生成博客静态资源 👉 : "

echo  "----------------"

hexo clean && rm -rf docs/*

hexo generate  && cp -r public/. docs

echo  "----------------"

echo  "🎈  远程库地址 🎈 :"

git remote -v

echo  "----------------"


function autoPush()
{
    # git返回信息中包含的错误字符串
	error_str="fatal"

	# 仓库add
    # 2>&1 的意思就是将标准错误重定向到标准输出。
	var=$(git add . 2>&1)
	echo $var

    git status

	# commit
	while [ "1" = "1"  ]
	do
		echo  "🌻  输入commit内容 🌻 :"
		read commit_msg
        echo  "--------------------->"
        echo  "🐙  提交日志中..."
        echo  "----------------"
		# 判断是否commit成功
		var=$(git commit -m "$commit_msg" 2>&1)
		echo $var
		if [[ "$var" =~ $error_str ]]; then
            echo  "----------------"
			echo "😥  提交错误 😥 "
            echo  "--------------------->"
            break
		else
            # echo  "--------------------->"
            # echo  "👏  commint 👏 "
			break
		fi
	done

	# push
	while [ "1" = "1" ]
	do
        echo  "----------------"
		echo  "😉  正在push到远程库... 😉   :"
        echo  "----------------"
		var=$(git push -u origin master 2>&1)
		if [[ $var =~ $error_str ]]; then
			var=$(git push -u origin master 2>&1)
		elif [[ $var =~ "git pull" ]]; then
			echo "😻  pull远程仓库 😻 "
			var=$(git pull 2>&1)
			echo $var
		else
			echo $var
            echo  "----------------"
            echo  "👏  push完成 👏 "
            echo  "--------------------->"
			break
		fi
	done
}


# Push
autoPush
