const { test, expect } = require('@playwright/test');

test('should have flutter-view tag', async ({ page }) => {
  await page.goto('http://localhost:8080');
  await expect(page.locator('flutter-view')).toBeVisible();
});
