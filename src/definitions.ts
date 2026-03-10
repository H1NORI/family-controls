export interface FamilyControlsPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  requestPermission(): Promise<{ granted: boolean }>;
}
