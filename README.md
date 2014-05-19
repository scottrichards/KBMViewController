KBMViewController
=================
The class KBMViewController will add support for scrolling up the view to prevent the keyboard from obscuring text fields.
Subclass any UIViewcontroller to get it to automatically scroll the text field above the keyboard. 
It works by adding a scrollview to the first subview of the UIViewController.view.  
So you will need to add a containing subview the UIViewControllers view.
