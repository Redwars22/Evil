<img src="./evil-logo.png">

**CSS MADE EASIER, SYNTACTICALLY CLEANER AND MORE READABLE!**

Evil is a minimalistic stylesheet language that can be easily converted to CSS. It lets you write CSS with a cleaner and more readable syntax. With Evil, you can do more with less typing. Its syntax doesn't use things such as semicolons and brackets: they aren't necessary, because they'll be added automatically when Evil code is converted to CSS. To convert Evil into usable CSS, just execute the Evil CLI by typing `ruby evil.rb` and then typing the name of the file (with the .evil extension) to be converted. Evil will automatically generate a file with the .css extension for you.

# INSTALLATION AND CODING IN EVIL CSS

If you are running EvilCSS for the first time in your machine, please run the `setup.sh` file first. It'll download all the Ruby dependencies required to make EvilCSS run seamlessly. After that, you can open your terminal and run `ruby evil.rb` to load Evil CLI. Once you're there, you can create a file with the `.evil` extension. Save it, go back to the CLI and then type the name of the file you've just created (you should include the `.evil` extension). After that, you should see a `.css` file that Evil CLI created automatically for you with the same name.

> ⚠️ **PLEASE NOTE THAT, SINCE EVILCSS IS AT ITS VERY EARLY DEVELOPMENT STAGES, YOU SHOULD ALWAYS REVISE AND CHECK IF THE GENERATED CSS CODE IS CORRECT.**

# EVILCSS SYNTAX RULES

EvilCSS' goal is to be simpler and quicker to type than regular CSS while still being familiar to programmers who already know and use CSS. One of the first things you're gonna notice when you start learning EvilCSS is that it doesn't user the typical curly-braces syntax that many languages use. Also, statements don't end with a semicolon.

All you need to create a block of code is one or more selectors followed by the `=>` symbol. In the following lines, you put all the attributes that affect those selectors. EvilCSS guesses where one block ends and another one starts, so no need for curly-braces! Here's an example!

**Regular CSS:**

```css
.button {
  --default-color: "#abcdef";
  background-color: var(--default-color);
  border-radius: 10px;
  color: "white";
}
```

**EvilCSS:**

```python
.button =>
    @default-color "#abcdef"
    background-color @default-color
    border-radius 10px
    color "white"
```

And, as you might've noticed, you also don't need to put colons, because EvilCSS' interpreter always assumes that the first word in a statement is the attribute and all the following words are the values.

Variables in EvilCSS are waaay easier than in CSS: to create one, just write its name followed by its value. AND DON'T FORGET TO PREFIX IT WITH `@`. To retrieve its value anywhere in your code, just access it by using its identifier prefixed with `@` as well. Example:

```python
div =>
    @bg-color "#000"
    background-color: @bg-color
```

You can and should comment your EvilCSS code when it gets larger and more complex. And, guess what, the way EvilCSS handles comments is similar to most programming languages you are probably familiar with: Just add two backslashes to the beginning of a comment. Those won't be present in the parsed CSS file, though, since they'll be completely ignored by the interpreter.

# MEDIA QUERIES

**Regular CSS**
```css
@media (max-width: 400px){
  body {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
  }

  .container {
    width: var(--width);
  }
}
```

**EvilCSS**
```python
? (max-width: 400px) =>
  body =>
    display flex
    flex-direction row
    flex-wrap wrap

  .container =>
    width @width
?
```
