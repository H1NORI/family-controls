import { WebPlugin } from '@capacitor/core';

import type { BlockGroup, FamilyControlsPlugin } from './definitions';

export class FamilyControlsWeb extends WebPlugin implements FamilyControlsPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async checkPermission(): Promise<{ status: boolean }> {
    console.warn('FamilyControls plugin is not available on web.');
    return { status: false };
  }

  async requestPermission(): Promise<{ granted: boolean }> {
    console.warn('FamilyControls plugin is not available on web.');
    return { granted: false };
  }

  async openAppPicker(options?: { id?: string }): Promise<{ selectedApps: number, selectedCategories: number, totalApps: number, totalCategories: number,}> {
    console.warn('FamilyControls plugin is not available on web.');
    console.log('Options: ', options);
    return { selectedApps: 0, selectedCategories: 0, totalApps: 0, totalCategories: 0 };
  }

  async getGroups(): Promise<{ groups: BlockGroup[] }> {
    console.warn('FamilyControls plugin is not available on web.');
    return { groups: [] };
  }

  async saveGroup(options: { id: string, name: string, blocking: number }): Promise<void> {
    console.warn('FamilyControls plugin is not available on web.');
    console.log('Options: ', options);
  }

  async blockGroup(): Promise<void> {
    console.warn('FamilyControls plugin is not available on web.');
  }

  async unblockAll(): Promise<void> {
    console.warn('FamilyControls plugin is not available on web.');
  }
}
