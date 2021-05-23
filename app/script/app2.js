const fs = require('fs').promises;
const puppeteer = require('puppeteer');

(async () => {
    try {
        const html = "/data/result.html";
        const buffer = await fs.readFile(html);

        const browser = await puppeteer.launch({
          args: [
            '--no-sandbox',
            '--disable-setuid-sandbox'
          ]
        });

        const page = (await browser.pages())[0];

        await page.goto(`data:text/html;base64,${buffer.toString("base64")}`);
        const scrapingData = await page.evaluate(() => {
        const dataList = [];
        const nodeList = document.querySelectorAll(".skuDisplayTable tbody tr td:nth-child(2)");
        nodeList.forEach(_node => {
            dataList.push(_node.innerText);
        })
        return dataList;
    });
        console.log(scrapingData[1]);
        browser.close();
    } catch(err) {
        console.log(err.toString());
    }

})();

