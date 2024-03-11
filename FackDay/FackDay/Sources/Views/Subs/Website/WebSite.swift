//
//  WebSite.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit

class WebSite: NSObject {
    func initHTML(dict: [String: String]) -> String {
        let stringHTML = """
        <html>
            <head>
                <meta name="apple-mobile-web-app-capable" content="yes">
                <meta name="apple-mobile-web-app-status-bar-style" content="default">
                <meta content="text/html charset=UTF-8" http-equiv="Content-Type" />
                <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no" />
                <link rel="apple-touch-icon" href="data:image/png;base64,\(String(describing: dict["image_1"]!))">
                <title>\(String(describing: dict["title"]!))</title>
            </head>
            <body>
                <a id="qbt" href =\(String(describing: dict["urlSchemes"]!))://></a>
                <a id="clickLinkWithPass" href =\(String(describing: dict["urlSchemes"]!))://></a>
                <div>
                    <div class = "title">
                        <label>Add icon to Home Screen</label>
                    </div>
                    <div class="image">
                        <img class = "icon" src = "data:image/png;base64, \(String(describing: dict["image_1"]!))" >
                    </div>
                    <div class = "title" style = "margin-top: 10px">
                        <label>\(String(describing: dict["title"]!))</label>
                    </div>
                    <div class="body">
                        <div>
                            <label style = "font-weight: bold">Step 1:</label>
                        </div>
                        <div style="margin-top: 20px">
                            <label>Click the button "Share" at the bottom of the page</label>
                        </div>
                        <div>
                            <img class="image-body" id="img_step_1" src="data:image/png;base64, \(String(describing: dict["img_step_1"]!))">
                        </div>
                    <div class="body">
                        <div style = "margin-top: 30px">
                            <label style="font-weight: bold">Step 2:</label>
                        </div>
                        <div style="margin-top: 20px">
                            <label>Scroll & Select " Add to Home Screen " from the pop-up menu.</label>
                        </div>
                        <div>
                            <img class="image-body" id="img_step_2" src="data:image/png;base64, \(String(describing: dict["img_step_2"]!))">
                        </div>
                    </div>
                </div>
            </body>
            <style>
                :root {
                    --color: #2B2F4B;
                    --text-align: center;
                    --font-size: 20px;
                    --font-style: normal;
                    --font-weight: normal;
                }
                .title {
                    padding: 10px;
                    margin-top: 30px;
                    text-align: var(--text-align);
                    font-style: var(--font-style)
                    font-weight: var(--font-weight)
                    font-size: var(--font-size);
                }
                .icon {
                    weight: 100px;
                    height: 100px;
                }
                .image {
                    text-align: var(--text-align);
                    margin-top: 10px;
                }
                img {
                    border-radius: 17px;
                }
                .body {
                    margin-top: 10px;
                    margin-left: 10px;
                    margin-right: 10px;
                    font-style: var(--font-style)
                    font-weight: var(--font-weight)
                }
                .image-body {
                    width: 100%;
                    margin-top: 10px;
                }
            </style>
            <script>
                if (window.navigator.standalone == true) {
                    document.getElementById("clickLinkWithPass").click()
                    document.getElementById("qbt").click()
                } else {
                    document.getElementById("div").style.display = "block"
                }

            </script>
        </html>
"""
        return stringHTML
    }

}
