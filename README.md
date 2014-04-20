NORLabelNode
============

Simple extension of Apple's `SKLabelNode`. Allowing multiple lines through the use of `\n` in the text-string. 
Usage: Behaves like an ordinary SKLabelNode with the one difference that adding newline characters to the text-
property actually adds line-breaks. This is achieved by creating SKLabelNodes as child-nodes, but keeping these as part of the internal (private) logic.

+ Language: Objective-C
+ Requirements: SpriteKit
+ iOS 7.0 / OSX 10.9 (or later) 


#License

 This software is created by T. Benjamin Larsen and can be included as a part of any software-project free of charge.
 No credits are required, but aknowledgement in any form is appreciated.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


#Usage

Use it like you would a regular SKLabelNode, whenever you want to have a line break simply include the newline character `\n` in the textstring. The space between lines can be adjusted through the `lineSpacing` (CGFloat) property. There is also a `numberOfLines` (NSUInteger) property (readonly). That's it.


#Installing

If [cocoapods](http://cocoapods.org) is your cup of Lipton thre is a pod available. If not, you can download the zip or clone from GitHub.


