VIMRC_PATH=~/.vimrc
VIMRC_GIT=${PWD}/.vimrc
default:
#touch ${VIMRC_PATH}
	@if [ -f ${VIMRC_PATH} ]; then rm ${VIMRC_PATH}; fi; ln -s ${VIMRC_GIT} ${VIMRC_PATH}

	git config --global alias.st status
	git config --global alias.co checkout
	git config --global alias.cm commit
	git config --global alias.br branch
	git config --global alias.cma commit --amend
clean:
	rm ${VIMRC_PATH}
