local task = require 'spooder' .task

task.test {
	description = "Runs tests";
	'rm luacov.stats.out || true';
	'luacheck . *.rockspec';
	'busted --coverage --lpath "?.lua"';
	'luacov -r html glass.lua';
}

task.documentation {
	description = "Builds and pushes the documentation";
	depends = "test";
	[[
		hash=$(git log -1 --format=%h)
		mkdir -p doc/coverage
		cp -r luacov-html/* doc/coverage
		ldoc .
		cd doc
			find . | treh -c
			git add --all
			if git log -1 --format=%s | grep "$hash$"
			then git commit --amend --no-edit
			else git commit -m "Update documentation to $hash"
			fi
			git push --force origin doc
		cd ../
		git stash pop || true
	]];
}
