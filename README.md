# CloudKit Journal
This app is designed to allow you to further develop your understanding of MVC, protocols and delegates, tableViews and adding a new skill of persistence through the CloudKit framework and database.
​
​
# Learning Objectives
* Further understanding of CKContainer and CKRecord
* Explore the differences between Public and Private databases
* Get more experience with CKQuery and NSPredicate
* Continued practice with MVC and Protocols and Delegates.
​
​
# Part One: CloudKit Capabilities,  Model and Controllers
### Enabling CloudKit Capabilities
* On  your project file navigate to ‘Signing and Capabilities’ 
* Setup your container and edit the name to reflect your Bundle Identifier
* Open CloudKit dashboard to ensure the container was created successfully
​
### Model
* Create your custom model object with the properties: title, body and timestamp. NOTE: you will need to build an extension to properly format your Date… reference previous projects to handle this.
* Create an extension on CKRecord and a convenience initializer that takes in  your Entry object
* Use the properties on your Entry object to set the Key/Value pairs for the CKRecord
* Create an extension on your Entry object that uses a failable convenience initializer to take in a CKRecord, set the values of the CKRecord from the properties keys.
​
### Model Controller
* Create your EntryController and set your Source of Truth array as well as your sharedInstance.
* Write your function declarations for Create and Read(save and fetch).
* Create a property for ‘privateDB’ and set it to your containers private database
* Fill in the body for your Create method:
	* take in a title, body and completion using Result. similar to your completion blocks in week 3 you will need to create an extension to handle your result Error.
	* call the ‘save’ function on your privateDB property
	* create a CKRecord called “entryRecord” using a new Entry to pass in to the save function
	* handle your error and build your first  case on your Error extension
	* unwrap the record and assign it to a saved Entry record
	* build your second case for your Error extension for not being able to unwrap
	* add to new entry to your Source of Truth and complete with success
* Fill in the body for your Fetch Function
	* should only take in completion using Resutlt as a parameter
	* call the ‘perform’ function on your privateDB property
	* build your CKQuery using ‘recordType’ and ‘predicate’
	* build your predicate using the ‘value’ parameter and setting it to ‘true’
	* pass your Query into the ‘perform’ function 
	* handle your error 
	* unwrap your records that have been returned
	* use the ‘compactMap’ higher order function on your returned records to create an array from those records
	* assign the new array to your ‘entries’ array.
	* complete with success
​
### View Controllers and Storyboard
* Create and constrain your storyboard. This should be exactly the same as the two previous Journal projects you created.
* Create the files for your Entry TableView and Entry Detail View, make sure you subclass the views.
* Drag out your outlets and actions on the Entry Detail View
* Going back to your Entry TableView, fill in the dataSource methods for numberOfRows and cellForRowAt
* Fill in your PrepareForSegue function and set your entryReceiver on the DetailView
* On your EntryDetailView:
	* conform to UITextFieldDelegate and call the function ‘textFieldShouldReturn’
	* within the function call the ‘resignFirstResponder’ function on your textField and return ‘true’
	* setup and ‘updateViews’ function takes an entry from the ‘entryReciever’ and sets the values for the textFields
	* handle your ‘ClearTextButtonTapped’ action similar to past Journal projects
	* handle your ‘saveButtonTapped’ similar to previous projects, but have the ‘popViewController’ function take place on the main thread.
	* in your ‘viewDidLoad’ call update views and assign the textField delegate
	* in your entryReceiver, use a did set to call ‘updateViews’ on the main thread.
* On your EntryTableView:
	* create an ‘updateViews’ function that accesses the main thread and adds the ‘reloadData’ function to the queue
	* As we are using the ‘popViewController’ function to come back to this View, we will need to use the ‘viewDidAppear’ function and call ‘reloadData’ within the definition of that function. 
	* finally in your ‘viewDidLoad’ use your sharedInstance to call your fetch function to pull in all your entries and call your ‘updateViews’ function
​
### Black Diamonds
* Implement Equatable and write a function that allows you to delete an Entry locally as well as from the CloudKit database
* Write a function that allows you modify(update) and Entry
	* reference CKModifyRecordOperation documentation for this functionality.
* Present the user with an alert for the appropriate error from CloudKit.
