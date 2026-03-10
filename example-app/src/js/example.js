import { FamilyControls } from 'family-controls';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    FamilyControls.echo({ value: inputValue })
}
