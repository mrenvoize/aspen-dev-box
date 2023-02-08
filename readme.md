#  Aspen Dev Environment

This is an Aspen-discovery Docker instance designed to make developing Aspen easier. Still in early stages and there are a number of improvements to be made


## ---  Installation ---

- Clone this repository into the same parent directory as your Aspen-discovery clone.

```sh
git clone https://github.com/Jacobomara901/aspen-dev-box.git
```
- Add these aliases to your bash/zshrc (amending the paths appropriately) and initialise your terminal again to source them.


> The parent folder that contains both your aspen clone directory and your aspen-dev-box directory
```
export ASPEN_DEV_BOX=~/Documents/aspendockerstruct
export ASPEN_CLONE=$ASPEN_DEV_BOX/aspen-discovery
export ASPEN_DOCKER=$ASPEN_DEV_BOX/aspen-dev-box
```

- Next, cd into aspen-dev-box folder and run docker compose
```sh
cd aspen-dev-box

docker compose up
```








