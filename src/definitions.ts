export interface FamilyControlsPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  checkPermission(): Promise<{ status: boolean }>;
  requestPermission(): Promise<{ granted: boolean }>;
  openAppPicker(options?: { id?: string }): Promise<{ selectedApps: number, selectedCategories: number, totalApps: number, totalCategories: number,}>;

  getGroups(): Promise<{ groups: BlockGroup[] }>;
  saveGroup(options?: { id?: string, name?: string, blocking?: number }): Promise<void>;
  blockGroup(): Promise<void>;
  unblockAll(): Promise<void>;
}

export interface BlockGroup {
  id: string
  name: string
  blocking: number
  selectedApps: number
  selectedCategories: number
  totalApps: number
  totalCategories: number
}