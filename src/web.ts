import { WebPlugin } from '@capacitor/core';

import type { FamilyControlsPlugin } from './definitions';

export class FamilyControlsWeb extends WebPlugin implements FamilyControlsPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async checkPermission(): Promise<{ granted: boolean }> {
    console.warn('FamilyControls plugin is not available on web.');
    return { granted: false };
  }

  async requestPermission(): Promise<{ granted: boolean }> {
    console.warn('FamilyControls plugin is not available on web.');
    return { granted: false };
  }

  async openAppPicker(): Promise<void> {
    console.warn('FamilyControls plugin is not available on web.');
  }
}
