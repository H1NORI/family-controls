import { registerPlugin } from '@capacitor/core';

import type { FamilyControlsPlugin } from './definitions';

const FamilyControls = registerPlugin<FamilyControlsPlugin>('FamilyControls', {
  web: () => import('./web').then((m) => new m.FamilyControlsWeb()),
});

export * from './definitions';
export { FamilyControls };
