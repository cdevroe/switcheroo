# Switcheroo - Little Arc for Safari

Switcheroo is a small open source macOS app that can be set as your default browser. When clicking a link from a third-party app (such as Slack or Mail) Switcheroo allows you to choose which Safari Profile you’d like a link to be loaded in.

## Contributors

- [Zhenyi Tan](https://andadinosaur.com) - [donate](https://andadinosaur.com/tip-jar)
- [Colin Devroe](https://cdevroe.com) - [donate](https://cdevroe.com/donate)

## Instructions

Currently, setting up existing Safari Profiles in Switcheroo is a bit cumbersome. This set of instructions assumes you have at least 2 Safari Profiles.

1. Open a new tab in an existing Profile (we'll call it Profile A) and navigate to any URL of your choice. E.g. https://github.com/cdevroe/switcheroo and move this tab to the left most pinned tab location and leave it open forever. This URL will be used by Switcheroo to identify which window contains Profile A.
1. Open Switcheroo's settings window
1. Type in the name of the Safari Profile A (the name does not need to match what is actually in Safari, the URL is the real identifier currently)
1. Paste the URL you chose for the left most tab of Safari Profile A
1. Hit the + button
1. Repeat for all the Safari Profiles you'd like set up in Switcheroo, be sure to choose a unique URL for each profile.
1. Set Switcheroo as your default browser in Settings > Desktop & Dock > Default web browser

## Contributing

- Submit any bugs or feature requests to GitHub issues.
- Browse GitHub Issues to find a task that needs to be done and assign it to yourself.  

## Version History

**0.2 - November 13, 2024**

- A macOS app icon
- A few fixes related to macOS Sequoia

**0.1 - March 19, 2024**

- Initial release
- Allows you to manually set up Safari Profiles
- Can be set as default browser
