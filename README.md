# discourse-show-private-categories

Discourse plugin to allow users to see categories read-limited categories and request access to them.

Adds a `show_private_categories` site setting. When enabled, read-restricted categories will show up in `/categories` with an explanatory message and a button to request access: 

![Access request message](doc/preview-01.png?raw=true "Access request message")

The button launches the private message composer and pre-populates it with some placeholder texts inthe subject and body.

At the moment, the plugin assumes there's a Group named exactly the same as the category `slug`. This group name will be used to populate the recipient field in the private message composer.

