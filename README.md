## GithubCommands
This section contains some common Git commands that can be used in the terminal to contribute to the project,
without causing destructive errors. Please check the [Contribute Section](#contribute) to
review the rules before accessing the repository. More commands can be found [here](https://uwnetid.sharepoint.com/:b:/r/sites/uwiac_seal_onedrive/Projects/Air%20Leaks/Hardware%20and%20Software%20Design/Software%20Design%20and%20Github/V0%20Github%20Access/git-cheat-sheet-education.pdf?csf=1&web=1&e=CBAfjG).
To use GitHub on VS Code, ensure that you download Git on your PC. The link can be found under "Source Control," located on the Activity bar on the left side of the screen.
### Opening up a project for the first time
1. First open VS Code and add an SSH key to your Github if you haven't already. [Link to Article.](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
2. Open the folder where you want to store the repository file.
3. Open the terminal and use the command below to clone the online repository.
``` bash
    git clone <URL>
```
4. Set the upstream path by using (where code goes when pushed):
``` bash
    git push -u origin /*branch-name*/
```
5. Now you have the current version of main on your PC. Please open a new branch before touching anything.
### Branching
- To See what branch you are currently in:
``` bash
    git branch
```
- To go to another branch:
``` bash
    git branch /*branch-name*/
```
- To create a branch and go into it:
``` bash
    git checkout -b /*branch-name*/
```
### Sending Code to GitHub
1. Check for new changes in code (use 'merge' changes have been made, but 'pull' doesn't register changes in main):
``` bash
    git pull
    git merge main
```
2. Get changed files ready to send:
``` bash
    git add .
```
3. Stage code to be ready to be sent to github (make sure to have a descriptive message):
``` bash
    git commit -m "desc. message on what has been done here"
```
4. Send code to your github branch:
``` bash
    git push                    //
```
