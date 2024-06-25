<h1>Odoo + VSCode</h1>
When first starting to develop on Odoo, setting up the development environment properly cna become frustrating. This script is meant to make it easier to initialize an environment to develop your customized addons. VSCode is a free IDE that can be properly set up to make development on Odoo easier.


<h2>Prerequisites</h2>
You must have VSCode, PostgreSQL server (default setup) and psql.
Then, set up a folder structure as such:

```
main_directory
    ----versions
        ----16.0
            ----odoo
            ----enterprise
        ----17.0
            ----odoo
            ----enterprise
    ----venv
        ----16.0
        ----17.0
    ----dev
        ----project_a
            ----module_a
        ----project_b
            ----module_b
```

Clone this repo somewhere accessible. It can be inside `dev` directory for example.

Inside `versions`, Odoo's codebases exist. There is no need for design-themes.

You must have a separate virtual environments for each Odoo version inside `venv`.

Your projects live in `dev`.

<h2>How to Install</h2>
Simply run `copy.sh` when you are inside the `dev` directory to copy the VSCode workspace for your project. For example:

```
odoo-vscode/copy.sh project_a 16.0 "MyProject"
```

This copies a workspace file for you for version 16.0 and names the workspace My Project.
The work space name argument is optional.


<h2>How to Use</h2>
Now, simply open the work space file inside `.vscode` directory inside the project's directory.

```
code project_a/.vscode/MyProject.code-workspace
```

This opens both of Odoo codebases inside the work space as well as your project directory. Now you can use various Run and Debug options and VSCode tasks as well as use VSCode search functionality to make use of what was done before to aid your development endeavours.

First, go to your code-workspace file and replace the `MODULE_NAME` with the name of the custom module you're currently developing.

```
        "odoo.module": "module_a",
```

For running an instance of Odoo locally, first run the `~Init DB` to create a databse and initialize your module. Then, you can choose `Run` from the Run and Debug menu of VSCode to start Odoo instance:
![image](https://github.com/Armin-FalDiS/odoo-vscode/assets/20294274/73e3c835-38cf-4bc4-8988-cdceaec04814)

From now on, you can simply use F5 to start Odoo with debugging. This allows the use of break points which help immensely with debugging. You can see your odoo instance on "http://localhost:8069/".

Every time you make a change on a JS file or XML file, you don't need to actually restart the server to see your changes. But restart the server when you make a change on your python files.

You don't need to "Init" every time of course just the first. Or when you want to install a fresh instance. Also, by having separate "odoo.module" in the vscode-workspace file for each module you're developing, you keep their data and code separate which reduces the chance of developing on obsolete or inconsistent states.

<h2>Recommended Extensions</h2>
To have some level of intellisence and autocomplete which takes your from developing on notepad to an actual modern IDE, the following extensions are really helpful:

[Auto Close Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-close-tag)
[Auto Rename Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-rename-tag)
[GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
[indent-rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)
[Odoo Code Snippets](https://marketplace.visualstudio.com/items?itemName=mstuttgart.odoo-snippets)
[Odoo IDE](https://marketplace.visualstudio.com/items?itemName=trinhanhngoc.vscode-odoo) --> This one is really helpful but may become paid in the future
[Owl Vision](https://marketplace.visualstudio.com/items?itemName=Odoo.owl-vision)
[Python Debugger](https://marketplace.visualstudio.com/items?itemName=ms-python.debugpy)
[Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv)
[Ruff](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff)
[XML Tools](https://marketplace.visualstudio.com/items?itemName=DotJoshJohnson.xml)

<h2>Pre-Commit</h2>
Working in a team-setting requires everyone to be on the same page which means when a team of different indivuals are working together, it's always a good idea to have everyone follow the same coding conventions.

At Odoo, we use a set of settings to format and style our code consistently and it's a great idea for you to follow suit since your code could be reviewed by Odoo one day and it might get rejected if it's not to Odoo's standards. A starting point could be using our pre-commit hooks to ensure you and your team are at least on the same page as us.

To initialize pre-commit hook on your project, simply run the task "~Init Pre-Commit". This fetches the configs and installs a hook on your project directory so that your changes are checked every time you try to commit something (hence the name).

After you push the code, from then on, any developer can use the "~Install Pre-Commit` task to install pre-commit. There is also the "~Run Pre-Commit" task to run pre-commit on all your project files.


<h2>Other Features</h2>
From the "Run and Debug" menu, you can also use "Test" which runs all the tests according to "odoo.testTags" of the workspace settings. You can also use "Shell" which gives you a shell to run code line by line to play around on Odoo if the need should arise.


You can change "odoo.logLevel" to make the logs either more or less verbose.


There is also a great feature to use templates to increase the speed of creating new databases. Imagine you have a `main` branch and you create a database from that. Then, on every other branch that you are developing, you simply copy that branch's database on install the module you are working on. This greatly reduces the time you'd have to wait to initialize new databases!

First, whilst on the branch that you are developing, run the "~Init Template DB` task to create the template database. Next, instead of "~Init DB" run the "~Init DB From Template". You can now see how faster this is. The bigger the database, the faster it would be to use this template feature to initialize it.

You can use "odoo.templateDB", "odoo.templateAddons" and "odoo.templateBranch" to control the name of the template database, which addons are to be installed on it and which branch should the template be created from.

If you had an error here, check your directory name since that is the default name for the database and PostgreSQL has strict policy on database names.
