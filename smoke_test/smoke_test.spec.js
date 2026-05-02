const { test, expect } = require('@playwright/test');

test('should have flutter-view tag', async ({ page }) => {
  await page.goto(process.env.URL);
  await expect(page).toHaveTitle(/Rebeca's Voxel World/);
  const flutterView = await page.$('flutter-view');
  expect(flutterView).not.toBeNull();
});

test('should have specific app element', async ({ page }) => {
  await page.goto(process.env.URL);
  const appElement = await page.$('#app');
  expect(appElement).not.toBeNull();
});
