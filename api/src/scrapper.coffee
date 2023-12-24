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
    
    browser = await puppeteer.launch { headless: "false" }
    page = await browser.newPage()

    await page.goto domain, { waitUntil: "networkidle0" }
    result = await page.evaluate query 

    await browser.close()
    
    return result


# Entire schedule, including:
#   - names
#   - pictures
#   - time
#   - links to more info
export getSchedule = () ->
    
    try
        scheduleTable = await getData "#{BASE_DOMAIN}/schedule", () ->
            document.getElementById("full-schedule-table").outerHTML
    catch
        log "error", "Error trying to fetch schedule from provider."
        return null

    # DOM
    $ = cheerio.load scheduleTable

    scheduleItems = {}
    currentDay = $("tr:first").find("h2").text()

    $("tr").each ( index, element ) ->

        if $(element).attr("class") is "day-of-week"
            currentDay = $(element).find("h2").text()
            return
        
        # Data parsing
        show = {
            "name": $(element).find("a").text(),
            "picture": $(element).find("a").attr("data-preview-image"),
            "time": $(element).find(".all-schedule-time:first").text(),
            "link": BASE_DOMAIN + $(element).find("a").attr("href")
        }

        if !scheduleItems.hasOwnProperty currentDay
            scheduleItems[currentDay] = []

        scheduleItems[currentDay].push show

    log "request", "Fetched schedule items from provider."
    return scheduleItems


# This receives the complete URL to a show
# Example: https://subsplease.org/shows/shy/
export getShowEpisodes = ( showURL ) ->

    try
        episodesTable = await getData showURL, () ->
            document.getElementById("show-release-table").outerHTML
    catch
        log "error", "Error trying to fetch episodes links from provider."
        return null

    # DOM
    $ = cheerio.load episodesTable

    episodesList = {}

    $("tr").each ( index, element ) ->

        episodeNumber = $(element).find(".episode-title:first").text()[-2..]

        # Data parsing
        episodeLinks = {}

        $(element).find(".links").each (index, element) ->

            magnetLink = "#{$(this).text()}": $(this).next("a").attr("href")
            episodeLinks = { ...episodeLinks, ...magnetLink }

        episodesList[episodeNumber] = episodeLinks

    log "request", "Fetched episodes links from provider."
    return episodesList


# Minimize load in schedule
export getShowYear = ( showURL ) ->

    try
        episodesTable = await getData showURL, () ->
            document.getElementById("show-release-table").outerHTML
    catch
        log "error", "Error trying to fetch show release year."
        return null

    # DOM
    $ = cheerio.load episodesTable
    
    millenium = new Date().getFullYear().toString()[0..1]
    decade = $("tr:last").find(".release-item-time:first").find("span:first").text()[-2..]

    showYear = millenium + decade

    log "request", "Fetched show release year from provider."
    return showYear