zip:
	@rm -f zsh-runtime.zip
	@find . -type f -name "*.vim" -a -not -name '*_test.vim' -a -not -name 'tvim.vim' | zip -@ zsh-runtime.zip

submit:
	@echo "Set environment variable '\$$MSG' to the tag message, like this:"
	@echo "MSG='My tag message'"
	@echo "git tag -f -s \`date +'%Y%m%d'\` -m \"\$$MSG\""

test:
	@git submodule update
	@./testing.vim/tvim test ./...

update-tests:
	@git submodule update
	./testing.vim/tvim gen-syn ./testdata/*.zsh > syntax_test.vim
