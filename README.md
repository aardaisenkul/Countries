<div id="top"></div>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/aardaisenkul/Countries">
    <img src="countryLogo.webp" alt="Logo" width="160" height="160">
  </a>

<h3 align="center">Countries App</h3>

</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

 The project lists 10 different countries for users. By accessing the details of the desired country, the user encounters the flag of that country, the country code and the button for more details. In addition, the user can favorite/unfavorite the countries they wanted to and can list and remove them within the saved page in the tabbar. 

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

* [Swift](https://developer.apple.com/swift/)
* [XCode 13.2.1](https://developer.apple.com/xcode/)
* [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)
* [Swift Package Manager](https://www.swift.org/package-manager/)
* [RapidAPI GeoDb Cities API](https://rapidapi.com/wirefreethought/api/geodb-cities/)
* [SDWebImage](https://github.com/SDWebImage/SDWebImage)
* [SDWebImageSVGCoder](https://github.com/SDWebImage/SDWebImageSVGCoder)
* [CoreData](https://developer.apple.com/documentation/coredata)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

After install required pod files, you can directly launch the app in XCode. After opening the location where the folder is located, it will be enough by following the steps below


### Installation

1. Get a free API Key at [RapidAPI](https://rapidapi.com/wirefreethought/api/geodb-cities/m)
2. Clone the repo
   ```sh
   git clone https://github.com/aardaisenkul/Countries.git
   ```
3. Install pod packages
   ```sh
   pod install
   ```
   If you have macbook with M1 Chip you can install pod files wia
   ```sh
   sudo arch -x86_64 gem install ffi
    arch -x86_64 pod install
   ```
4. Enter your API in `RapidAPI`
   ```swift
   let API_KEY = 'ENTER YOUR API';
   ```

<p align="right">(<a href="#top">back to top</a>)</p>

### Requirements

* Xcode 13
* Swift 5
* IOS 15.x 

<!-- USAGE EXAMPLES -->
## Visual
| Demo |  
| --- | 
| ![Preview](gif.gif) | 

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- With the help of a custom cell, the cell with the star icon and the name of the required country was designed.
- This cell has been added to the home page, which is the first option in the tab bar.
- With a similar design of the home page, it was possible to sort the cells which is saved.
- Thanks to 2 different methods added to the custom cell, adding to favorites and going to country details actions are provided.
- With a design similar to the saved page, it was possible to sort the cells recorded in the plain.
- Started to design and code detail page
    -  Thanks to SDWebImageSVGCoder, the necessary image was fetched and placed on the detail page, which was a challenging detail as I had not used pod packages before.
    - Other datas are fetched such as wikicode and country name from the relevant API. More info button has been added and it redirects with the help of wikicode to the wikipedia. 
    - The country name is fixed in the header.
    - Finally, the star button on the right of the header was designed and coded to add that country to favorites.


<p align="right">(<a href="#top">back to top</a>)</p>



<!-- FEATURES -->
## Features
1. CoreData is used for handling to add/remove countries to the saved list
2. Data layer(repository): includes model needs for api logic tabbar pages
3. ViewModel layer: includes some methods and logic that can be useful
4. View layer: includes of view controllers and storyboards

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- THINGS THAT COULD BE BETTER -->
## Things That Could Be Better
1. Kazakhistan country flag size can be optimized because its size or type are not like others
2. Instant refresh could be better on saved page when user interacts with favorite process. 
3. Some performance improvements can be made to make app durable

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Ali Arda İsenkul - [@LinkedIn](https://www.linkedin.com/in/aardaisenkul/) - ardaisenkul@hotmail.com

Project Link: [https://github.com/aardaisenkul/Countries](https://github.com/aardaisenkul/Countries)

<p align="right">(<a href="#top">back to top</a>)</p>




<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge
[contributors-url]: https://github.com/github_username/repo_name/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge
[forks-url]: https://github.com/github_username/repo_name/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge
[stars-url]: https://github.com/github_username/repo_name/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge
[issues-url]: https://github.com/github_username/repo_name/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge
[license-url]: https://github.com/github_username/repo_name/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
