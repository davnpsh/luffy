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


# 'domain' has to be a domain name
# 'query' has to be a JS function to evaluate in the browser
getData = ( domain, query ) ->
    
    browser = await puppeteer.launch({ headless: "false", slowMo: 400 })
    page = await browser.newPage()

    await page.goto( domain )
    result = await page.evaluate( query )

    await browser.close()
    
    return result


# Entire schedule, including:
#   - names
#   - covers
#   - links to description
export getSchedule = () ->
    
    scheduleTable = await getData "https://subsplease.org/schedule/", () ->
        document.getElementById("full-schedule-table").innerHTML

    scheduleItems = {}

    # DOM
    $ = cheerio.load(scheduleTable)

    $("tr").each ->
        console.log $(this).find("h2").text()