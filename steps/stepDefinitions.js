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

Given("the user is on the login page", async () => {
  await page.waitForLoadState("networkidle");
});

When("the user enters valid username and password", async () => {
  await page.fill('#username', 'validUsername');
  await page.fill('#password', 'validPassword');
});

Then("the user is logged in successfully", async () => {
  await page.click('#loginButton');
  await expect(page).toHaveTitle(/Dashboard/);
});