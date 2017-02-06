VIMRC_PATH=~/.vimrc
VIMRC_GIT=${PWD}/.vimrc
default:
#touch ${VIMRC_PATH}
	@if [ -f ${VIMRC_PATH} ]; then rm ${VIMRC_PATH}; fi; ln -s ${VIMRC_GIT} ${VIMRC_PATH}

clean:
	rm ${VIMRC_PATH}
