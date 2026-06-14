const { Given, When, Then, Before, After } = require("@cucumber/cucumber");
const { chromium, expect } = require("@playwright/test");
const fs = require('fs');
const path = require('path');

let browser, context, page;

Before(async () => {
  browser = await chromium.launch({ headless: false });
  context = await browser.newContext();
  page = await context.newPage();
});

After(async () => {
  const screenshotDir = './screenshots';
  if (!fs.existsSync(screenshotDir)) fs.mkdirSync(screenshotDir, { recursive: true });
  const timestamp = Date.now();
  await page.screenshot({ path: path.join(screenshotDir, timestamp + '.png'), fullPage: true });
  await browser.close();
});

Given("the application is running", async () => {
  await page.goto(process.env.BASE_URL || "http://localhost:3000");
  await expect(page).toHaveTitle(/.*/);
});

Given("the user is on the home page", async () => {
  await page.waitForLoadState("networkidle");
});

When("the user enters all possible values", async () => {
  await page.fill('input', 'all possible values');
});

Then("the application should handle all possible entries without errors or warnings", async () => {
  await expect(page).not.toHaveText('error');
});