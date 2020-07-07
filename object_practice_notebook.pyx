
current_id = 0

class Notebook:
    """This is a notebook to store your notes"""

    def __init__(self):
        """Initialize the notebook with an empty notes dictionary"""
        self.notes = []

    def new_note(self):
        """Add a new note to the notebook"""
        new_note_text = input("What should the new note text say? ")
        new_note = Note()
        new_note.edit_text(new_note_text)
        self.notes.append(new_note)

    def edit_note(self,note_id, text):
        """Change a given note"""
        for note in self.notes:
            if note_id == note.id:
                note.text = text
                break

    def edit_tags(self, note_id):
        """Add or remove tags from a given note"""
        for note in self.notes:
            if note_id == note.id:
                note.tags = input("What new tags do you want? ")

class Note:
    """A note to store whatever text you want."""

    def __init__(self, tags=''):
        """Initialize the note with a sample string
        and a blank list of tags"""
        global current_id
        self.id = current_id
        current_id += 1
        self.text = "Sample text to be written over"
        self.tags = ''

    def edit_text(self, text):
        """The ability to edit a memo. Requires text to ensure
        the user only overwrites their text if they absolutely
        want to. Also prints the change to the user."""

        self.text = text
        print("Note with ID {0} change to text: \n {1}".format(self.id, self.text))

    def edit_tags(self, tags):
        """The ability to edit a memo. Requires text to ensure
        the user only overwrites their text if they absolutely
        want to. Also prints the change to the user."""

        self.tags = tags
        print("Tags on note with ID {0} changed to: \n {1}".format(self.id, self.tags))

    def tag_match(self, tag):
        """Return true if a tag matches the tags on this note"""

        return tag in self.memo


class Menu:
    """Display a menu of options to the user"""
    def __init__(self):
        self.notebook = Notebook()
        self.choices = {
            '1':self.show_notes,
            '2':self.search_notes,
            '3':self.add_note,
            '4':self.edit_note,
            '5':self.quit
        }

    def display_menu(self):
        """Display the menu of available options"""
        print("""Notebook Menu

              1. See existing notes
              2. Search existing notes
              3. Add a new note
              4. Edit an existing note
              5. Quit
              """)

    def run(self):
        """Show the menu until the action is to quit"""
        while True:
            self.display_menu()
            choice = input("Enter a selection 1-5 ")
            action = self.choices.get(choice)
            if action:
                action()
            else:
                print("{x} is not a valid choice. Try another option.".format(x=choice))

    def show_notes(self):
        if len(self.notebook.notes)>0:
            print('ID     Text')
            for note in self.notebook.notes:
                print(note.id, '   ',note.text[:20])
        else:
            print("There are no notes. Try making one!")

    def search_notes(self):
        """Search for notes with a given piece of text or tags"""
        if len(self.notebook.notes)==0:
            print("There are no notes to search through. Try making one!")
            return
        # Return true if a search string is in the note
        def match_string(search_string,note):
            if search_string in note:
                return note.id

        while True:
            search_string = input("What would you like to search for? ")
            if len(search_string)>0:
                print(self.notebook.notes)
                match_list = [match_string(search_string, note) for note in self.notebook.notes]
                if len(match_list) > 0:
                    cleaned_list = str(match_list)[1:-1]
                else:
                    print("There were no matches for {0}".format(search_string))
                    break
                print("The matching note IDs for '{0}' were {1}.".format(search_string,cleaned_list))
                break
            else:
                print("Try entering text...")

    def add_note(self):
        """Add a new note with text and optionally tags"""
        self.notebook.new_note()

    def edit_note(self):
        """Edit a given note's text or tags"""
        if len(self.notebook.notes)>0:
            print("The following notebooks are available...")
            self.show_notes()
        else:
            print("There are no notes.")
            return

        mod_id = input("Which note would you like to modify? ")
        global current_id
        if not int(mod_id) <= current_id:
            print("Not a valid ID. Try again.")
            return
        new_text = input("Type in the text for that note... ")
        new_tags = input("Type in the tags you want for that note, separated by commas... ")

        if new_text:
            self.notebook.edit_note(mod_id, new_text)

        if new_tags:
            self.notebook.edit_tags(mod_id, new_tags)

    def quit(self):
        """Allow the user to exit the program, but confirm first."""
        while True:
            print_confirm = input("Are you sure you want to exit? Yes/No ")
            if print_confirm == "Yes":
                print("Thanks for using this notebook. Goodbye!")
                exit(0)
            elif print_confirm == "No":
                print("Cancelling quit and returning back to main menu.")
                break
            else:
                print("I did not understand...")

"""Run the script only when it's being called by this file"""
if __name__ == "__main__":
    Menu().run()