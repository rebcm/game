const { test, expect } = require('@playwright/test');

test('should have flutter-view tag', async ({ page }) => {
  await page.goto('https://example.com'); // replace with the actual URL
  const flutterView = await page.$('flutter-view');
  expect(flutterView).not.toBeNull();
});
