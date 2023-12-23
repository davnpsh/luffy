###
Anime Seasonals Web Scrapper
CREDITS: https://subsplease.org/

Released under GPLv2 license

DISCLAIMER:
    I am not related in any kind of form to Subsplease.
    Please, consider supporting them directly via seeding
    their torrents or not using this tool.
    This is just a project to learn about CoffeeScript.
###


import puppeteer from "puppeteer"
import * as cheerio from "cheerio"


BASE_DOMAIN = "https://subsplease.org"


# 'domain' has to be a domain name
# 'query' has to be a JS function to evaluate in the browser
getData = ( domain, query ) ->
    
    browser = await puppeteer.launch { headless: "false", slowMo: 400 }
    page = await browser.newPage()

    await page.goto domain
    result = await page.evaluate query 

    await browser.close()
    
    return result


# Entire schedule, including:
#   - names
#   - pictures
#   - time
#   - links to more info
export getSchedule = () ->
    
    scheduleTable = await getData "#{BASE_DOMAIN}/schedule", () ->
        document.getElementById("full-schedule-table").outerHTML

    # DOM
    $ = cheerio.load scheduleTable

    scheduleItems = {}
    currentDay = $("tr:first").find("h2").text()

    $("tr").each ( index, element ) ->

        if $(element).attr("class") is "day-of-week"
            currentDay = $(element).find("h2").text()
            return
        
        # Data extraction
        show = {
            "name": $(element).find("a").text(),
            "picture": $(element).find("a").attr("data-preview-image"),
            "time": $(element).find(".all-schedule-time:first").text(),
            "link": $(element).find("a").attr("href")
        }

        if !scheduleItems.hasOwnProperty currentDay
            scheduleItems[currentDay] = []

        scheduleItems[currentDay].push show

    return scheduleItems