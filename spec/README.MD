
# Mini-Vim (coding test)

## Initial requirements

We're going to emulate the following vim commands:
1. Navigation: 0, $, e, t[char]
2. Selection: v[navigation command]
3. Example Command Usage:

| Input | Command | Output | Description |
|--|--|--|--|
| hello world | 0 | [h]ello world | Move to the first character |
| hello world | $ | hello worl[d] | Move to the last character |
| hello world | e | hell[o] world | Move to the [e]nd of the word |
| hello world | tw | hello[ ]world | Move un[t]il the next matching character |
| hello world | ve | [hello] world | [v]isually select until the [e]nd of the word |
| hello world | v$ | [hello world] | [v]isually select until the last character |
| hello world | vtw | [hello ]world | [v]isually select un[t]il the character 'w' |

Assumptions:
1. Input is a single line of ascii text, no longer than 30 characters.
2. [] chars are only used for showing the curser position / selection in the output.
3. Series of commands can be provided to navigate through the text as shown below:

```
Example interactions:
Input Text: Hello World
Command: e
Output: Hell[o] World
Command: e
Output: Hello Worl[d]
Command: v0
Output: [Hello World]
Command: tw
Output: Hello[ ]World
```
Tasks:
4. Build an object oriented system.
5. Include unit tests.
6. Implement as many of the aforementioned commands as you can based on your own time, in the order specified.

## Implementation
For implementation Ruby programming language has been chosen.

Assumption about 30 chars input is not taken intp account.
As a person who is not a Vim user I had to assumpt some of specifics:
- First char of the input is selected by default
- Input is trimmed from starting and ending whitespaces by default
- When a whitespace is selected and command ***e*** is supplied, last char of a next word is selected

### Requirements before installation
One needs to [install Ruby interpreter](https://www.ruby-lang.org/en/documentation/installation/](https://www.ruby-lang.org/en/documentation/installation/). Ruby version 2.7+ is reccomended, lower versions were not tested.
### Installation
- Clone the repository
- Go into solution folder
- Run `bundle install` to install the dependencies
### Run
Inside the solution folder open a terminal and run `ruby main.rb`
### Testing
Inside the solution folder open a terminal and run `rspec`
`spec/functions_spec.rb` file has one commented test case as it tests `exit` command which brakes the testing. In case one wants to run test on it, uncomment it and run `rspec spec/spec/functions_spec.rb`. Other test files can be run separately in the same manner.