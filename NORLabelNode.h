/*
 NORLabelNode.h
 
 A simple extension of SKLabelNode allowing for multiline-labes in SpriteKit through the use of nextline characters.
 
 This software is created by T. Benjamin Larsen and can be included as a part of any software-project free of charge.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
*/

#import <SpriteKit/SpriteKit.h>
/** A subclass of SKLabelNode adding multiline functionality by using the regular \"\\n\" nextline character in the text-string. */
@interface NORLabelNode : SKLabelNode <NSCopying>

/// The number of text-lines in the node.
@property (nonatomic, readonly, assign) NSUInteger numberOfLines;
/// The float value controlling the space between lines. It works by multiplying the font's pointSize. The default value is 1.5.
@property (nonatomic, assign) CGFloat lineSpacing;

@end
