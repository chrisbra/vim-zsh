zip:
	@rm -f zsh-runtime.zip; find . -type f -name "*.vim" | zip -@ zsh-runtime.zip

submit:
	@echo "Set environment variable '\$$MSG' to the tag message, like this:"
	@echo "MSG='My tag message'"
	@echo "git tag -f -s \`date +'%Y%m%d'\` -m \"\$$MSG\""
