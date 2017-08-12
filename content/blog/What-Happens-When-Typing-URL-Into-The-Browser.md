---
title: "What Happens When Typing URL Into The Browser"
date: 2017-08-09
tags: ["Interview", "TCP/IP", "HTTP"]
draft: false
---

### What Happens When Typing URL Into The Browser
<br/>
#### Description
What happens when you type www.google.com into the browser? Outline the "life of a request" from beginning to end.

<br/>
#### My Answer
##### **High-level outline**
* Browser check it's cache to see if it has been to that domain name before.

	After user typed www.google.com in browser's url bar and clicked enter, browser will check the input with the domain IP pair in it's cache. If it exists, then browser gets IP address directly and skip next step.

* Browser sends request to DNS and get an IP address.

	Browser sends request to local DNS server, take www.google.com as an example:

	1. Local DNS sends request about looking for www.google.com to the root DNS ".", and it will return DNS for ".com" to local DNS.
	2. Local DNS then sends request to look for www.google.com to ".com" DNS, and also return DNS for "google.com".
	3. Local DNS then sends request to "google.com" DNS and gets IP of "www.google.com".

* Browser uses the IP address + the port number to connect to the server via TCP/IP.

	Browser connects to the server with IP:port via TCP/IP. The port number may be explicitly or implicitly described in the URL. And for HTTP, the port number is 80, while HTTPS is 443.

* Google is obviously a huge site with many servers, so some kind of load-balancing is involved to route the request to a specific available server.

	We may first get the IP for Google's load-balancing server, so after first TCP/IP request, it may send browser a new IP address which links to a specific available Google server.

* Browser uses the TCP stream thus opened up to start sending text to the server.

* Browser sends an HTTP request (which is just text) to tell the server which path, host, and "verb" it is requesting.

	After opened a TCP stream, browsers can start sending HTTP requests. Browser may also check it's cache for cookies of this site. A HTTP request may contain path, host, and "verb" (GET, POST, etc), and also cookies and headers.

* The HTTP request also contains a variety of other important headers which tell the server who you are and more about what you want.

* The server process the text of the HTTP request into a request object in memory.

* The resulting bundle of HTML, inline JavaScript, inline CSS, and possibly inlined binary data, is packaged up into an HTTP response.

* The HTTP response is shipped back through the TCP stream.

* The browser begins parsing the big wad of text in the HTTP response.

* As HTML, JavaScript, CSS are parsed, more HTTP requests are sent out to fetch more assets for the page.

	The browser must start parsing the HTML from the first line step by step to the last line of the HTML file. And if there are some script files requred, the browser will also send HTTP request to where it can get the response.

* The browser executes script and renders the results of all its parsing to the viewport.

	Because the browser must execute HTML and script line by line and render the results of all what it has parsed, it may stop rendering and wait for executing script file for a while. And Javascript file may take time to execute. Therefore, to make website work efficiently and render the site as fast as it can, it is always good to move all javaScript files to the bottom of the HTML file and move all CSS files to the beginning of the HTML file. Then the browser can render the website quickly and execute JavaScript files after rendering most of the stuff.