describe('Smoke Test', () => {
  it('should load the Flutter app', () => {
    cy.visit('/');
    cy.get('flt-glass-pane').should('be.visible');
  });
});
