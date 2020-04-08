# Spotehfi-ahk - deprecated

Spotehfi-ahk is an __incomplete__ application written in [AutoHotkey](https://www.autohotkey.com/), open-sourced for use and/or for further [development](#usage-instructions). 

### Table of Contents

**[Features](#features)**<br>
**[Had Planned](#un-available-features)**<br>
**[Usage Instructions](#usage-instructions)**<br>
**[Initial Setup](#initial-setup)**<br>
**[Miscellaneous](#miscellaneous)**<br>
**[Credits](#credits)**

## Features

### Available Features

Spotehfi-ahk contains a few features, of which are complete, were tested and fully functional on **Windows 10**, **64-Bit**.

#### Spotify Search

Browse Spotify for what's currently playing.

#### Share Spotify URI's

Generate `spotify:search:` URI's and Copy to Clipboard. (e.g. [spotify:search:D-Block+&+S-te-Fan+-+Love+On+Fire](https://open.spotify.com/track/4Y0mxfotUhzTeFJySxhaD4?si=ga2iA8j6SbyvGUiUl_Dh_A))

#### YouTube Search

Browse YouTube for what's currently playing.

#### YouTube Download

Using [youtube-dl](https://github.com/ytdl-org/youtube-dl), you're able to download what's currently playing in Spotify from YouTube.

## Un-available Features

### Had Planned

A number of features were planned for this project, however, I decided to no-longer develop spotehfi in `.ahk`.

#### Bulk Downloads

Allow users to queue multiple URL's, and/or a playlist/album from either Spotify or YouTube.

#### Extended History

Display an extended log of track's users have listened to within Spotify w/ support for search, and filters. (beyond **50**)

  * Each logged entry would be paired with two icon buttons, of which have different functionalities. Read below.
  
      * The first icon button would allow for the user to download the track from YouTube. (if available)
      
      * The second icon button would allow for the user to Copy a shareable URI to their Clipboard.

## Usage Instructions

### Release

1. Download the initial spotehfi-ahk [release](https://github.com/Jxyme/spotehfi-ahk/releases/tag/v0.0.1.0) from this repo. (marked as a *pre-release* as spotehfi-ahk is incomplete)
2. Extract the **spotehfi-ahk-0.0.1.0.zip** to a partition/directory of your choice.
3. Run **spotehfi.ahk**.

### Development

1. Clone or Fork this repo.
   * Make a Pull request from your repo/branch and I will review the changes, and merge it. (credits given)
   
## Initial Setup

### User Preferences

Spotehfi-ahk will prompt you with an 'initial setup' the first time you launch, and will save your preferences to file.

#### Font

Apply the optional, but **recommended** font ([Circular Std Book](https://github.com/ixahmedxi/circular-std)) for a cleaner appearance, and a better experience.

#### Output Directory

Browse for a directory of your choice, or allow spotehfi-ahk to output YouTube downloads to the root directory.

## Miscellaneous

### Link Detection

Spotehfi-ahk will detect any __valid__ Spotify URI/URL. Highlighting a URI, followed by `CTRL+C` will open it in Spotify.

### URL Conversion

When copying an `open.spotify` URL, spotehfi-ahk will automatically convert it into one of the supported URI's.
* Below you can find a list of supported URI's, followed by an example. All of which will open in Spotify when copied.
   * Search: `spotify:search:` 
   
      * Example: `spotify:search:D-Block+&+S-te-Fan+-+Love+On+Fire`
      
   * Track: `spotify:track:`
   
      * Example: `spotify:track:4dGMiYXnQLp1iXlc4BllaO`
      
   * Playlist: `spotify:playlist:`
   
      * Example: `spotify:playlist:7omgVeGV53YWDFwOFrA4xO`
      
   * Album: `spotify:album:`
   
      * Example: `spotify:album:6rLCvkI1WfZ0j4X5QRCYy4`
      
   * Artist: `spotify:artist:`
   
      * Example: `spotify:artist:7E6DrjKJieOdJKO8mbwCMO`
      
   * User: `spotify:user:`
   
      * Example: `spotify:user:u0v8q4i3uv52187c4nhw1mm4r`

### User Settings

Spotehfi-ahk has a few user settings which can be accessed via the :gear:. These settings are saved in `Settings.ini`.

#### Colours

![Colours](https://github.com/Jxyme/spotehfi-ahk/blob/master/screenshots/Colours.png?raw=true)

#### Output

Browse for a directory of your choice, or use the default. This'll be used for future YouTube `.mp3` downloads.

## Credits

Spotehfi-ahk was developed by [Jxyme](https://github.com/Jxyme), with some assistance from [jordhardwell](https://github.com/jordhardwell) in early January 2020 (?)

* AutoHotkey: [Website](https://www.autohotkey.com/) | [GitHub](https://github.com/AutoHotkey/AutoHotkey)
  * AddTooltip v2.0: [Script by jballi](https://www.autohotkey.com/boards/viewtopic.php?f=6&t=30079)

* FFmpeg: [Website](https://www.ffmpeg.org/) | [Source Code](https://www.ffmpeg.org/download.html#get-sources) | [GitHub](https://github.com/FFmpeg/FFmpeg)
* youtube-dl: [Website](http://ytdl-org.github.io/youtube-dl/) | [GitHub](https://github.com/ytdl-org/youtube-dl/)

## Notice

*The documentation/features may be __incomplete__, if I happen to come across something which is missing, I will update this file.*
